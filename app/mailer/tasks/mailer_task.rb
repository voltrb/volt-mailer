unless RUBY_PLATFORM == 'opal'
  require 'pony'
  require 'volt/page/path_string_renderer'
end

class Mailer < Volt::Task
  def deliver(view_path, attrs)
    attrs = attrs.symbolize_keys

    raise ":to must be supplied when delivering e-mail" unless attrs[:to]

    subject = Volt::PathStringRenderer.new("#{view_path}/subject", attrs).html

    text = begin
      Volt::PathStringRenderer.new("#{view_path}/text", attrs).html
    rescue ViewLookupException => e
      nil
    end

    html = begin
      Volt::PathStringRenderer.new("#{view_path}/html", attrs).html
    rescue ViewLookupException => e
      nil
    end

    if !text && !body
      raise "No text or html version of the e-mail supplied in #{view_path}"
    end

    # If no html version is supplied, use the text version.
    html ||= "<pre>#{text}</pre>"

    attrs[:subject] = subject
    attrs[:html_body] = html
    attrs[:body] = text

    # Merge attrs into a copy of the mailer options
    attrs = Volt.config.mailer.to_h.dup.merge(attrs) if Volt.config.mailer

    allowed_opts = Pony.permissable_options

    pony_options = attrs.select {|k,v| allowed_opts.include?(k.to_sym) }

    # Send the e-mail
    Pony.mail(pony_options)

    true
  end
end