require 'pony'

class UserConfirmationMailer

	def self.send_confirmation_email(user)

		# send the email to the user
		Pony.mail(
			to: user.email,
			via: :smtp,
			via_options: {
				address: 'smtp.gmail.com',
				port: '587',
				enable_starttls_auto: true,
				user_name: 'arempejunk@gmail.com',
				password: ENV['GMAIL_PASS'],
				authentication: :plain,
				domain: 'localhost.localdomain'
			},
			headers: { 'Content-Type' => 'text/html' },
			subject: 'McDaniel Textbook Exchange Confirmation',
			body: "Hello #{user.name},\n\nPlease follow <a href='localhost:9393/confirm?token=#{user.confirmation_token}'>this link</a> to confirm your email address"
		)

		# update user information
		user.confirmation_sent_at = DateTime.now
		user.save
	end
end