@varbase-ai-safety @ai @recipes @a11y @local @development @staging @production
Feature: Varbase AI Recipe - AI Safety - Accessible image upload
  As a content editor who uses assistive technology
  I want the image form that runs the safety check to work with a keyboard and a screen reader
  So that I can add images like anyone else

  Scenario: Check the add image form gives every field a label and every link a name
    Given I am a logged in user with the "Content editor" user
     When I go to "/media/add/image"
     Then every form field should have an accessible label
      And every link should have an accessible name
      And every ARIA role should be valid
