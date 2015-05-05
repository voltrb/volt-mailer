# Volt::Mailer

An easy way to send e-mail from your Volt app.

## Installation

Add this line to your application's Gemfile:

    gem 'volt-mailer'

And then execute:

    $ bundle

## Usage

## Templates

When using volt-mailer, you create .email templates and deliver them based on their path.  (Typically at app/main/views/mailers/*.email)

Email templates have three sections in a single file:

```html
<:Subject>
  Welcome

<:Html>
  <h1>Welcome {{ name }}</h1>

  <p>...</p>

<:Text>
Welcome

...

```

## Delivery

On the client or the server you can send an e-mail with:

```ruby
Mailer.deliver('path/to/views', {to: 'someone@address.com'}).then do
  # email sent
end.fail do |errors|
  # failed to send, handle errors
end
```

Mailer.deliver takes two arguments, the path to your mailer and a hash of options.  In a new volt project, there will be an "app/main/views/mailer" folder.  Any view with .email (or .html) can be used.  Normally you would use a .email view.  Views with the .email extension will not be loaded on the client.

If you skip the :Html section, the :Text section will be used for the html e-mail.

The ```Mailer``` class is a Volt::Task, so the deliver method returns a promise.  Be sure to handle the fail.

The second argument is a hash of options.  volt-mailer uses the [pony gem](https://github.com/benprew/pony) under the hood to deliver the mail.  Any supported pony options will be passed to pony during the sending.  All options passed in will be exposed as methods inside of the email template.  If a matching controller is provided, the options will be set as the controllers model.

## Attachments

Because Volt uses the [pony gem](https://github.com/benprew/pony), you can pass any pony options as the second argument to deliver to add attachments, reply_to, message_id's, etc..


## Mailer Config

Commonly when sending e-mails, you'll need to globally configure things like the :via and :via_options, and the :from address.  This can be configured in Volt.configure block in your app.  Volt provides default setup options out of the box.