Feature: selective filtering

    In order to get just the results I like
    As a picky web developer using typogruby
    I want to only apply certain filters to a file

    Background:
        Given a file named "input.html" with:
        """
        <p>"This IS a simple file!</p>
        """

    Scenario: using just one filter
        When I run `typogruby -w input.html`
        Then the output should contain exactly:
        """
        <p>"This IS a simple&nbsp;file!</p>
        """
        And the exit status should be 0

    Scenario: using just several filters
        When I run `typogruby -cw input.html`
        Then the output should contain exactly:
        """
        <p>"This <span class="caps">IS</span> a simple&nbsp;file!</p>
        """
        And the exit status should be 0

    Scenario: excluding a single filter
        When I run `typogruby --no-widows input.html`
        Then the output should contain exactly:
        """
        <p><span class="dquo">&#8220;</span>This <span class="caps">IS</span> a simple file!</p>
        """
        And the exit status should be 0

    Scenario: excluding multiple filters
        When I run `typogruby --no-widows --no-caps input.html`
        Then the output should contain exactly:
        """
        <p><span class="dquo">&#8220;</span>This IS a simple file!</p>
        """
        And the exit status should be 0
