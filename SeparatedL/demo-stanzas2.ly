\version "2.20.0"
#(set-global-staff-size 24)

% un-comment the next line to remove Lilypond tagline:
% \header { tagline="" }

\pointAndClickOff

\paper {
  print-all-headers = ##t %% allow per-score headers

  % un-comment the next line for A5:
  % #(set-default-paper-size "a5" )

  % un-comment the next line for no page numbers:
  % print-page-number = ##f

  % un-comment the next 3 lines for a binding edge:
  % two-sided = ##t
  % inner-margin = 20\mm
  % outer-margin = 10\mm

  % un-comment the next line for a more space-saving header layout:
  % scoreTitleMarkup = \markup { \center-column { \fill-line { \magnify #1.5 { \bold { \fromproperty #'header:dedication } } \magnify #1.5 { \bold { \fromproperty #'header:title } } \fromproperty #'header:composer } \fill-line { \fromproperty #'header:instrument \fromproperty #'header:subtitle \smaller{\fromproperty #'header:subsubtitle } } } }

  % Might need to enforce a minimum spacing between systems, especially if lyrics are below the last staff in a system and numbers are on the top of the next
  system-system-spacing = #'((basic-distance . 7) (padding . 5) (stretchability . 1e7))
  score-markup-spacing = #'((basic-distance . 9) (padding . 5) (stretchability . 1e7))
  score-system-spacing = #'((basic-distance . 9) (padding . 5) (stretchability . 1e7))
  markup-system-spacing = #'((basic-distance . 2) (padding . 2) (stretchability . 0))
}

%{ The jianpu-ly input was:
KeepLength
NoIndent

% tempo: 4=120
4/4

% Print many verses in multiple columns
% https://lilypond.org/doc/v2.24/Documentation/notation/stanzas#printing-stanzas-at-the-end-in-multiple-columns

c3 2 1 2  |  3 3 3 3   |  2 2 3 2  |  1 - - -

L: Ma- ry had a lit- tle lamb, its fleece was white as snow.
%}


\score {
<< \override Score.BarNumber.break-visibility = #center-visible
\override Score.BarNumber.Y-offset = -1
\set Score.barNumberVisibility = #(every-nth-bar-number-visible 5)

%% === BEGIN JIANPU STAFF ===
    \new RhythmicStaff \with {
    \consists "Accidental_engraver" 
    %% Get rid of the stave but not the barlines:
    \override StaffSymbol.line-count = #0 %% tested in 2.15.40, 2.16.2, 2.18.0, 2.18.2, 2.20.0 and 2.22.2
    \override BarLine.bar-extent = #'(-2 . 2) %% LilyPond 2.18: please make barlines as high as the time signature even though we're on a RhythmicStaff (2.16 and 2.15 don't need this although its presence doesn't hurt; Issue 3685 seems to indicate they'll fix it post-2.18)
    }
    { \new Voice="W" {
    \override Beam.transparent = ##f
    \override Stem.direction = #DOWN
    \override Tie.staff-position = #2.5
    \tupletUp
    \override Stem.length-fraction = #0
    \override Beam.beam-thickness = #0.1
    \override Beam.length-fraction = #0.5
    \override Voice.Rest.style = #'neomensural % this size tends to line up better (we'll override the appearance anyway)
    \override Accidental.font-size = #-4
    \override TupletBracket.bracket-visibility = ##t
\set Voice.chordChanges = ##t %% 2.19 bug workaround

    \override Staff.TimeSignature.style = #'numbered
    \override Staff.Stem.transparent = ##t
     \time 4/4 #(define (note-three grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "3")))))))
  \applyOutput #'Voice #note-three e'4
#(define (note-two grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "2")))))))
  \applyOutput #'Voice #note-two d'4
#(define (note-one grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "1")))))))
  \applyOutput #'Voice #note-one c'4
  \applyOutput #'Voice #note-two d'4 | | %{ bar 2: %}
  \applyOutput #'Voice #note-three e'4
  \applyOutput #'Voice #note-three e'4   \applyOutput #'Voice #note-three e'4   \applyOutput #'Voice #note-three e'4 | | %{ bar 3: %}
  \applyOutput #'Voice #note-two d'4
  \applyOutput #'Voice #note-two d'4   \applyOutput #'Voice #note-three e'4   \applyOutput #'Voice #note-two d'4 | \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 4: %}
  \applyOutput #'Voice #note-one c'4
 ~ \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 #(define (note-dashone grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashone c'4
 ~ \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~   \applyOutput #'Voice #note-dashone c'4 \bar "|." } }
% === END JIANPU STAFF ===

\new Lyrics = "IX" { \lyricsto "W" { Ma --
ry had a lit --
tle lamb, its fleece was white as snow. } } 
>>
\layout{ indent = 0.0 } }
\score {
\unfoldRepeats
<< 

% === BEGIN MIDI STAFF ===
    \new Staff { \new Voice="Y" { \time 4/4 e'4 d'4 c'4 d'4 | | %{ bar 2: %} e'4 e'4 e'4 e'4 | | %{ bar 3: %} d'4 d'4 e'4 d'4 | | %{ bar 4: %} c'1 } }
% === END MIDI STAFF ===

>>
\midi { \context { \Score tempoWholesPerMinute = #(ly:make-moment 84 4)}} }
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
