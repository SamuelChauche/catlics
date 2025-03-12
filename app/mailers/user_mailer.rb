class UserMailer < ApplicationMailer
  default from: "no-reply@catlics.fr"

  def order_email(order)
    # on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @order = order

    # on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = "http://catlics.fr/users/sign_in"

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @order.user.email, subject: "recapitulatif de la commande !")
  end
end
