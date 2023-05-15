class AttendanceMailer < ApplicationMailer
  default from: 'psgforever83@hotmail.com'

  def welcome_attendance_email(attendance)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @attendance = attendance
    @event = @attendance.event
    @user = @event.administrator

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://monsite.fr/login' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: "Bienvenue à l'évenement!") 
  end
end
