class HomeController < ApplicationController
  def index
    @mail = EssayApplication.new
  end

  def submit
    @mail = EssayApplication.new essay_application_params

    if @mail.save
      EssayMailer.essay_application(@mail).deliver_now
      @mail = EssayApplication.new
      @submited = true
    end

    # HACK HACK HACK HACK HACK HACK
    @mail.errors.messages.keys.each do |field|
      if @mail.errors.messages[field].size > 1
        @mail.errors.messages[field].delete_if{|err| err == "can't be blank"}
      end
    end
    # HACK HACK HACK HACK HACK HACK

  end

  def essay_application_params
    application_params = params[:essay_application]
    application_params[:essays_attributes] =  (application_params[:essays] || []).map{|p| {essay: p}}

    params[:essay_application].delete(:essays) if params[:essay_application]

    params.require(:essay_application).permit(:first_name,
                                              :last_name,
                                              :email,
                                              :phone,
                                              :photo,
                                              :transcript,
                                              :recommendation,
                                              essays_attributes: [:essay])
  end

end
