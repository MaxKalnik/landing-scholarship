class EssayMailer < ActionMailer::Base

  def essay_application(application)
    @essay_application = application
    mail(to: ENV['MAIL_TO'], subject: 'Essay', template_name: 'essay_application')
  end
end
