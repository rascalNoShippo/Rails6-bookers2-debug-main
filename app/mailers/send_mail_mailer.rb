class SendMailMailer < ApplicationMailer
  def soushin(member, event)
    @name = member.name
    @event = event
    mail to: member.email, subject: "イベントが追加されました"
  end

end
