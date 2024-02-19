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
}

\score {
<< \override Score.BarNumber #'break-visibility = #center-visible
\override Score.BarNumber #'Y-offset = -1
\set Score.barNumberVisibility = #(every-nth-bar-number-visible 5)

%% === BEGIN JIANPU STAFF ===
    \new RhythmicStaff \with {
    \consists "Accidental_engraver" 
   %% Limit space between Jianpu and corresponding-Western staff
   \override VerticalAxisGroup.staff-staff-spacing = #'((minimum-distance . 7) (basic-distance . 7) (stretchability . 0))

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
     \time 2/4 #(define (note-two grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "2")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8.[^.
( #(define (note-three grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "3")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e''16]^.
) #(define (note-one grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "1")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c''16[^.
( #(define (note-six grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "6")))))))
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a'16
#(define (note-five grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "5")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
) | %{ bar 2: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a'16[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e''16.[^.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #3
  \applyOutput #'Voice #note-three e''32^.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e''16^.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d''16]^.
| %{ bar 3: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c''16.[^.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #3
  \applyOutput #'Voice #note-one c''32^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-five g'4 \bar "|." } }
% === END JIANPU STAFF ===


%% === BEGIN 5-LINE STAFF ===
    \new Staff \with { instrumentName = "Soprano" } {
    \override Score.SystemStartBar.collapse-height = #11 % (needed on 2.22)
    \new Voice="5line" {
    #(set-accidental-style 'modern-cautionary)
    \override Staff.TimeSignature #'style = #'numbered
    \set Voice.chordChanges = ##f % for 2.19.82 bug workaround
 \time 2/4 d''8. ( e''16 ) c''16 ( a'16 g'8 ) | %{ bar 2: %} a'16 c''8 a'16 e''16. e''32 e''16 d''16 | %{ bar 3: %} c''16. c''32 a'8 g'4 \bar "|." } }
% === END 5-LINE STAFF ===


%% === BEGIN JIANPU STAFF ===
    \new RhythmicStaff \with {
    \consists "Accidental_engraver" 
   %% Limit space between Jianpu and corresponding-Western staff
   \override VerticalAxisGroup.staff-staff-spacing = #'((minimum-distance . 7) (basic-distance . 7) (stretchability . 0))

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
     \time 2/4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8.[^.
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e''16]^.
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c''16[^.
( \set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a'16
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
) | %{ bar 2: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e''16.[^.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #3
  \applyOutput #'Voice #note-three e''32^.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e''16^.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g''16]^.
| %{ bar 3: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-five g'16.[
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #3
  \applyOutput #'Voice #note-five g'32
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
  \applyOutput #'Voice #note-six a'4 \bar "|." } }
% === END JIANPU STAFF ===


%% === BEGIN 5-LINE STAFF ===
    \new Staff \with { instrumentName = "Alto" } {
    \override Score.SystemStartBar.collapse-height = #11 % (needed on 2.22)
    \new Voice="5line" {
    #(set-accidental-style 'modern-cautionary)
    \override Staff.TimeSignature #'style = #'numbered
    \set Voice.chordChanges = ##f % for 2.19.82 bug workaround
 \time 2/4 d''8. ( e''16 ) c''16 ( a'16 g'8 ) | %{ bar 2: %} c'16 d''8 c'16 e''16. e''32 e''16 g''16 | %{ bar 3: %} g'16. g'32 g'8 a'4 \bar "|." } }
% === END 5-LINE STAFF ===

>>
\layout{} }
\score {
\unfoldRepeats
<< 

% === BEGIN MIDI STAFF ===
    \new Staff { \new Voice="midi" { \time 2/4 d''8. ( e''16 ) c''16 ( a'16 g'8 ) | %{ bar 2: %} a'16 c''8 a'16 e''16. e''32 e''16 d''16 | %{ bar 3: %} c''16. c''32 a'8 g'4 } }
% === END MIDI STAFF ===


% === BEGIN MIDI STAFF ===
    \new Staff { \new Voice="midi" { \time 2/4 d''8. ( e''16 ) c''16 ( a'16 g'8 ) | %{ bar 2: %} c'16 d''8 c'16 e''16. e''32 e''16 g''16 | %{ bar 3: %} g'16. g'32 g'8 a'4 } }
% === END MIDI STAFF ===

>>
\midi { \context { \Score tempoWholesPerMinute = #(ly:make-moment 84 4)}} }
