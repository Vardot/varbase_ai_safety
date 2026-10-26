@varbase-ai-safety @ai @recipes @a11y @local @development @staging @production
Feature: Varbase AI Recipe - AI Safety - Accessible image upload
  As a content editor who uses assistive technology
  I want the image form that runs the safety check to work with a keyboard and a screen reader
  So that I can add images like anyone else

  Scenario Outline: Check the add image form keeps the "<rule>" accessibility rule
    Given I am a logged in user with the "Content editor" user
     When I go to "/media/add/image"
     Then the page should not violate the accessibility rule "<rule>"

    Examples:
      | rule              |
      | label             |
      | link-name         |
      | duplicate-id-aria |
      | aria-valid-attr   |
