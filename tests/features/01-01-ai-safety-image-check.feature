@varbase-ai-safety @ai @recipes @local @development
Feature: Varbase AI Recipe - AI Safety - Images are checked before they are saved
  As a content editor
  I want every image I upload to be checked by the site's vision model
  So that nothing unsuitable for a general audience is published by mistake, and every check is on record

  # A real vision model must find this landscape safe. Echo's reply is not a
  # verdict, so on Echo the upload is refused: the check fails closed.
  @live-ai
  Scenario: Verify an editor's image is checked and saved
    Given I am a logged in user with the "Content editor" user
     When I go to "/media/add/image"
      And I fill in "Name" with "Green hills at noon"
      And I attach the file "landscape.jpg" to the "Add a new file" field
      And I wait max of 30 seconds
     Then I see visible alternative text field
     When I fill in "Alternative text" with "Green hills under a sunny sky"
      And I click the "Save" button
     Then I should see "Green hills at noon"
      And I should not see "This image was flagged as Moderate or Restricted"

  # The check runs on upload, whatever the verdict, and is logged on any provider.
  Scenario: Verify the check on an editor's image upload is kept in the AI log
    Given I am a logged in user with the "Content editor" user
     When I go to "/media/add/image"
      And I fill in "Name" with "Green hills at dusk"
      And I attach the file "landscape.jpg" to the "Add a new file" field
      And I wait max of 30 seconds
      And I logout
    Given I am a logged in user with the "Webmaster" user
     When I go to "/admin/config/ai/logging/collection"
     Then I should see "You are a strict content-safety classifier"
