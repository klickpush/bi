class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ensure_logged_in

  def ensure_logged_in
    console.log('Ensured Logged In Begin')
    unless (request.referer.blank? && session['redirected'].present?)
      console.log('Request: ' + request.referer)
      if request.referer.present? && (URI.parse(request.referer).host.include?('0.0.0.0')  || URI.parse(request.referer).host.include?('klickpush.com') )
        console.log('Setting Session')
        session['redirected'] = 1
      else
        console.log('Failed to set session')
        reset_session
        redirect_to 'https://www.klickpush.com'
      end
    end
    console.log('Ensured Logged In End')
  end
end
