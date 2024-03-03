\markup {
  % \fontsize #3 % Adjust font size as needed
  \column {

   \string-lines
     "Verse 2. \n Everywhere that Mary went \n The lamb was sure to go."

    \string-lines
      "Verse 3.
       All the children laugh and play,
       To see a lamb at school.         \n--------------------------------------------------"

    \line { "Verse A:  \n" }
    \line { "The first line of verse 1. \n" }
    \line { "The second line of verse 1. \n" }
    %\hfill
  }

  % adds horizontal spacing between columns
  \hspace #0.1 % No use!
  \column {

    {
      \line \italic { Verse 4. }
      \line { And so the teacher turned it out, }
      \line { But still it lingered near. }
      %\line { -------------------------------------------------- }
    }

    \wordwrap-string "
      Verse 5.

      Mary took it home again,

      It was against the rule.

      --------------------------------------------------"

     %"Verse B:  \n"
     \line { "Verse B:  \n" }
    "The first line of verse 2. \n"
    "The second line of verse 2. \n"
    %\hfill
  }
}
