Feature: Simple usage

    In order to improve my web file's typography
    As a web developer using typogruby
    I want to apply typogruby to a file

    Scenario: getting help
        When I run `typogruby -h`
        Then the output should contain "Usage: typogruby [options] filename [filename, ...]"
        And the exit status should be 0

    Scenario: getting the version number
        When I run `typogruby -v`
        Then the output should contain "Typogruby "

    Scenario: filtering a file
        Given a file named "input.html" with:
        """
        <p>"This IS a simple file!</p>
        """
        When I run `typogruby input.html`
        Then the output should contain exactly:
        """
        <p><span class="dquo">&#8220;</span>This <span class="caps">IS</span> a simple&nbsp;file!</p>
        """
        And the exit status should be 0

    Scenario: Writing output to a file
        Given a file named "input.html" with:
        """
        <p>"This IS a simple file!</p>
        """
        When I run `typogruby -o output.html input.html`
        Then the file "output.html" should contain exactly:
        """
        <p><span class="dquo">&#8220;</span>This <span class="caps">IS</span> a simple&nbsp;file!</p>
        """
        And the exit status should be 0
