Feature: ignoring parts of a file

    In order to not mess up mixed files
    As a web developer using typogruby
    I want to filter just HTML and not Javascript

    Scenario:
        Given a file named "input.html" with:
        """
        <script>
        document.write("<p>Foo BAR!</p>");
        </script>
        <p>"This IS a simple file!</p>
        """
        When I run `typogruby input.html`
        Then the output should contain exactly:
        """
        <script>
        document.write("<p>Foo BAR!</p>");
        </script>
        <p><span class="dquo">&#8220;</span>This <span class="caps">IS</span> a simple&nbsp;file!</p>
        """
        And the exit status should be 0
