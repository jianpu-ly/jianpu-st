\version "2.18.0"
#(set-global-staff-size 20)

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

\score {
<< \override Score.BarNumber #'break-visibility = #center-visible
\override Score.BarNumber #'Y-offset = -1
\set Score.barNumberVisibility = #(every-nth-bar-number-visible 5)

%% === BEGIN JIANPU STAFF ===
    \new RhythmicStaff \with {
    \consists "Accidental_engraver" 
    %% Get rid of the stave but not the barlines:
    \override StaffSymbol #'line-count = #0 %% tested in 2.15.40, 2.16.2, 2.18.0, 2.18.2, 2.20.0 and 2.22.2
    \override BarLine #'bar-extent = #'(-2 . 2) %% LilyPond 2.18: please make barlines as high as the time signature even though we're on a RhythmicStaff (2.16 and 2.15 don't need this although its presence doesn't hurt; Issue 3685 seems to indicate they'll fix it post-2.18)
    }
    { \new Voice="jianpu" {

    \override Beam #'transparent = ##f % (needed for LilyPond 2.18 or the above switch will also hide beams)
    \override Stem #'direction = #DOWN
    \override Tie #'staff-position = #2.5
    \tupletUp

    \override Stem #'length-fraction = #0.5
    \override Beam #'beam-thickness = #0.1
    \override Beam #'length-fraction = #0.5
    \override Voice.Rest #'style = #'neomensural % this size tends to line up better (we'll override the appearance anyway)
    \override Accidental #'font-size = #-4
    \override TupletBracket #'bracket-visibility = ##t
\set Voice.chordChanges = ##t %% 2.19 bug workaround

    \override Staff.TimeSignature #'style = #'numbered
    \override Staff.Stem #'transparent = ##t
     \tempo 4=56 \mark \markup{1=D} \time 4/4 \new Voice="tmp0" {

    \override Beam #'transparent = ##f % (needed for LilyPond 2.18 or the above switch will also hide beams)
    \override Stem #'direction = #DOWN
    \override Tie #'staff-position = #2.5
    \tupletUp

    \override Stem #'length-fraction = #0
    \override Beam #'beam-thickness = #0.1
    \override Beam #'length-fraction = #0.5
    \override Voice.Rest #'style = #'neomensural % this size tends to line up better (we'll override the appearance anyway)
    \override Accidental #'font-size = #-4
    \override TupletBracket #'bracket-visibility = ##t
\set Voice.chordChanges = ##t %% 2.19 bug workaround
#(define (note-nought grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "0")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[] } 
#(define (note-two grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "2")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16[
#(define (note-three grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "3")))))))
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16]
#(define (note-one grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "1")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
]  #(define (note-five grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "5")))))))
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
| %{ bar 2: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8.[-\tweak #'X-offset #0.6 _.
#(define (note-six grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "6")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16]-\tweak #'X-offset #0.6 _.
#(define (note-seven grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "7")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-seven b16[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~ #(define (note-dashsix grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashsix a4
\repeat volta 2 { | %{ bar 3: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16[-\tweak #'X-offset #0.6 _.
\mp \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
]    \applyOutput #'Voice #note-three e'4. | %{ bar 4: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
]  (   \applyOutput #'Voice #note-six a4.-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
) \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 5: %}
  \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~ \mf   \applyOutput #'Voice #note-dashsix a4 \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~ #(define (note-dashfive grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashfive g4
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 6: %}
  \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~   \applyOutput #'Voice #note-dashfive g4 \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~   \applyOutput #'Voice #note-dashsix a4 | %{ bar 7: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8.[
\mf \set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8.[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16]
  \applyOutput #'Voice #note-two d'4 | %{ bar 8: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8.[
\> \set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
) \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~   \applyOutput #'Voice #note-dashfive g4 \! } \alternative { { | %{ bar 9: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8.[
\mf \set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8.[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g16]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 10: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8[-\tweak #'X-offset #0.6 _.
]  \> (   \applyOutput #'Voice #note-seven b4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[]-\tweak #'X-offset #0.6 _.
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~   \applyOutput #'Voice #note-dashsix a4 \! } { | %{ bar 11: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8.[
\mf \set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8.[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
| %{ bar 12: %}
  \applyOutput #'Voice #note-five g'4.
\< \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-three e'4
 ~ #(define (note-dashthree grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashthree e'4
\! }} \repeat volta 2 { | %{ bar 13: %}
  \applyOutput #'Voice #note-six a'4.
\f ( \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a'16[
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g'16]
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
]  \once \textLengthOn  #(define-markup-command (jianpu-grace layout props text)
(markup?) "Draw right-pointing jianpu grace under text."
(let ((textWidth (cdr (ly:stencil-extent (interpret-markup layout props (markup (#:fontsize -4 text))) 0))))
(interpret-markup layout props
(markup
  #:line
  (#:right-align
   (#:override
    (cons (quote baseline-skip) 0.2)
    (#:column
     (#:line
      (#:fontsize -4 text)
      #:line
      (#:pad-to-box
       (cons -0.1 0)  ; X padding before grace
       (cons -1.6 0)  ; affects height of grace
       (#:path
        0.1
        (list (list (quote moveto) 0 0)
              (list (quote lineto) textWidth 0)
              (list (quote moveto) 0 -0.3)
              (list (quote lineto) textWidth -0.3)
              (list (quote moveto) (* textWidth 0.5) -0.3)
              (list (quote curveto) (* textWidth 0.5) -1 (* textWidth 0.5) -1 textWidth -1)))))))))))) 
  \applyOutput #'Voice #note-one c''4.^. ^\tweak outside-staff-priority ##f ^\tweak avoid-slur #'inside ^\markup \jianpu-grace { \line { "6" } }
| %{ bar 14: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g'16[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c''16[^.
( \set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d''16^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
) \once \textLengthOn  \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-six a'4
 ~ ^\tweak outside-staff-priority ##f ^\tweak avoid-slur #'inside ^\markup \jianpu-grace { \line { "7" } }
  \applyOutput #'Voice #note-dashsix a'4 | %{ bar 15: %}
  \applyOutput #'Voice #note-six a'4.
( \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a'16[
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g'16]
) \once \textLengthOn  \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
]  ^\tweak outside-staff-priority ##f ^\tweak avoid-slur #'inside ^\markup \jianpu-grace { \line { "5" } }
  \applyOutput #'Voice #note-two d'4. | %{ bar 16: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16[
( \set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g'16
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a'16]
) \once \textLengthOn  \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-three e'4
 ~ ^\tweak outside-staff-priority ##f ^\tweak avoid-slur #'inside ^\markup \jianpu-grace { \line { "5" } }
  \applyOutput #'Voice #note-dashthree e'4 | %{ bar 17: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16[-\tweak #'X-offset #0.6 _.
\mf \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16.[
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #3
  \applyOutput #'Voice #note-three e'32
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16.[
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #3
  \applyOutput #'Voice #note-one c'32
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16]
  \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
| %{ bar 18: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16.[
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #3
  \applyOutput #'Voice #note-three e'32
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g16[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g16-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
  \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
} \alternative { { | %{ bar 19: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8.[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16]
  \applyOutput #'Voice #note-three e'4 \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-one c'4
 ~ #(define (note-dashone grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashone c'4
} { | %{ bar 20: %}
  \applyOutput #'Voice #note-five g4.-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\f \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[]-\tweak #'X-offset #0.6 _.
  \applyOutput #'Voice #note-two d'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 21: %}
  \applyOutput #'Voice #note-one c'4
 ~ \< ( \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~   \applyOutput #'Voice #note-dashone c'4 | %{ bar 22: %}
  \applyOutput #'Voice #note-one c'4
) \!   \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-nought r4 }} \bar "|." } }
% === END JIANPU STAFF ===

\new Lyrics = "IX" { \lyricsto "jianpu" { \override LyricText #'self-alignment-X = #LEFT \repeat unfold 13 { \skip 1 } 你  是  我  生  命  之  中  生  命  的  摇  篮  呣  呣  呣  呣  山  高  水  远  挡  不  住  回 　  家  路  你  是  梦  中  看  不  够  的  一  幅  画 　 　 　  　 　 　 　 　 　 　 　   啊 想 你  亲 爱 的 母 亲  啊 想 你  难 忘 的 故 乡  那 里 有 父 老 乡 亲 殷 切 的 期　 望  那 里 有 华 夏 儿 女 一 生 牵 挂  一 生 牵 挂 } } \new Lyrics = "IY" { \lyricsto "jianpu" { \override LyricText #'self-alignment-X = #LEFT \repeat unfold 13 { \skip 1 } 你  是  我  生  命  之  中  生  命  的  摇  篮  呣  呣  呣  呣   千  里  万  里  隔  不  断  对  你  思  念 　 　 　  　 　 　 　 　 　 　 　  你  是  心  中  唱  不  尽  的  一  首  歌  啊 想 你  亲 爱 的 母 亲  啊 想 你  难 忘 的 故 乡  那 里 有 兄 弟 姐 妹 亲 人 的 爱 恋  那 里 是 海 外 游 子 盼 归 的 根 　 　 　 　  盼 归 的 根 } } 
>>
\header{
title="想家"
arranger="词:王远亮 曲:郭坦"
}
\layout{} }
\score {
\unfoldRepeats
<< 

% === BEGIN MIDI STAFF ===
    \new Staff { \new Voice="midi" { \tempo 4=56 \transpose c d { \key c \major  \time 4/4 r8 d'16 e'16 c'8 d'8 e'8 g'4 e'8 | %{ bar 2: %} g8. a16 b16 a16 g8 a2 \repeat volta 2 { | %{ bar 3: %} a16 \mp c'8 a16 e'8 e'8 d'8 e'4. | %{ bar 4: %} d'16 d'8 d'16 d'8 ( e'8 ) c'8 ( a4. ) | %{ bar 5: %} a2 \mf g2 | %{ bar 6: %} g2 a2 | %{ bar 7: %} e'8. \mf g'16 g'8 e'8 c'8. d'16 d'4 | %{ bar 8: %} e'8. \> e'16 c'8 ( a8 ) g2 \! } \alternative { { | %{ bar 9: %} c'8. \mf c'16 c'8 c'8 g8. g16 g8 a8 | %{ bar 10: %} b8 \> ( b4 ) g8 a2 \! } { | %{ bar 11: %} c'8. \mf c'16 c'8 c'8 d'8. d'16 d'8 d'8 | %{ bar 12: %} g'4. \< e'8 e'2 \! }} \repeat volta 2 { | %{ bar 13: %} a'4. \f ( a'16 g'16 ) a'8 \grace { a'16 } c''4. | %{ bar 14: %} g'16 g'8 a'16 c''16 ( d''16 b'8 ) \grace { b'16 } a'2 | %{ bar 15: %} a'4. ( a'16 g'16 ) \grace { g'16 } a'8 d'4. | %{ bar 16: %} a16 c'8 a16 d'16 ( e'16 g'16 a'16 ) \grace { g'16 } e'2 | %{ bar 17: %} a16 \mf c'8 a16 e'16. e'32 e'16 d'16 c'16. c'32 a16 c'16 g4 | %{ bar 18: %} c'16 d'8 c'16 e'16. e'32 e'16 e'16 g16 g16 g8 a4 } \alternative { { | %{ bar 19: %} c'8. c'16 e'4 c'2 } { | %{ bar 20: %} g4. \f a8 d'4. e'8 | %{ bar 21: %} c'4  ~ \< ( c'2. | %{ bar 22: %} c'4 ) \! r2. }} } } }
% === END MIDI STAFF ===

>>
\header{
title="想家"
arranger="词:王远亮 曲:郭坦"
}
\midi { \context { \Score tempoWholesPerMinute = #(ly:make-moment 84 4)}} }
