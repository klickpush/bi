class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ensure_logged_in

  def ensure_logged_in
    logger.debug('Ensured Logged In Begin')
    unless (request.referer.blank? && session['redirected'].present?)
      logger.debug('Request: ' + request.referer.to_s)
      if request.referer.present? && (URI.parse(request.referer).host.include?('0.0.0.0') || URI.parse(request.referer).host.include?('klickpush.com'))
        logger.debug('Setting Session')
        session['redirected'] = 1
      else
        logger.debug('Failed to set session')
        reset_session
        redirect_to 'https://www.klickpush.com'
      end
    end
    logger.debug('Ensured Logged In End')
  end
end
