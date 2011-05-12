Feature: various inputs

    In order to work quickly
    As a hasty web developer using typogruby
    I want to use various input methods

    Background:
        Given a file named "input.html" with:
        """
        <p>"This IS a simple file!</p>
        """
        And a file named "input2.html" with:
        """
        <p>This is another file</p>
        """

    @wip
    Scenario: take input from STDIN
        When I run `typogruby < input.html`
        Then the output should contain exactly:
        """
        <p><span class="dquo">&#8220;</span>This <span class="caps">IS</span> a simple&nbsp;file!</p>
        """
        And the exit status should be 0

    Scenario: multiple input files
        When I run `typogruby input.html input2.html`
        Then the output should contain exactly:
        """
        <p><span class="dquo">&#8220;</span>This <span class="caps">IS</span> a simple&nbsp;file!</p><p>This is another&nbsp;file</p>
        """
        And the exit status should be 0
