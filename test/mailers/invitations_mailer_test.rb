require "test_helper"

class InvitationsMailerTest < ActionMailer::TestCase
  test "invitation_instructions" do
    mail = InvitationsMailer.invitation_instructions
    assert_equal "Invitation instructions", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
