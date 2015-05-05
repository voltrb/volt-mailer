unless RUBY_PLATFORM == 'opal'
  require 'pony'
  require 'volt/page/path_string_renderer'
end

class Mailer < Volt::Task
end