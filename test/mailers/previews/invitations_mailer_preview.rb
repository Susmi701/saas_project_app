# Preview all emails at http://localhost:3000/rails/mailers/invitations_mailer
class InvitationsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invitations_mailer/invitation_instructions
  def invitation_instructions
    InvitationsMailer.invitation_instructions
  end

end
