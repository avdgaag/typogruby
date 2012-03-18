Feature: processing caps

    In order to be smart about caps
    As a web developer using typogruby
    I want to be fine-grained about what is and is not included within my caps tag

    Scenario:
        Given a file named "input.html" with:
        """
        L. A. Paul is a name
        L.A.P.D. is an acronym
        LA is the normal case
        LA. is a twist on the normal case that does no harm
        LA..PD and LA...PD are fringe cases, but also do no harm
        
        """
        When I run `typogruby -c input.html`
        Then the output should contain exactly:
        """
        L. A. Paul is a name
        <span class="caps">L.A.P.D.</span> is an acronym
        <span class="caps">LA</span> is the normal case
        <span class="caps">LA.</span> is a twist on the normal case that does no harm
        <span class="caps">LA..PD</span> and <span class="caps">LA.</span>..<span class="caps">PD</span> are fringe cases, but also do no harm
        
        """
        And the exit status should be 0
