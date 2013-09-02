OmniAuth.config.logger = Rails.logger

   Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '266925696752524','592ec74435beb2985503c99f83aa1f84'
   end
	
