class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ensure_logged_in

  def ensure_logged_in
    unless (request.referer.blank? && session['redirected'].present?)
      if request.referer.present? && (URI.parse(request.referer).host.include?('0.0.0.0')  || URI.parse(request.referer).host.include?('klickpush.com') )
        session['redirected'] = 1
      else
        reset_session
        redirect_to 'https://www.klickpush.com'
      end
    end
  end
end
