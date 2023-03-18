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
     #(define (note-five grob grob-origin context)
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
  \applyOutput #'Voice #note-five g'8[
#(define (note-six grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "6")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-five g'4 #(define (note-three grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "3")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
#(define (note-two grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "2")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
| %{ bar 2: %}
  \applyOutput #'Voice #note-three e'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
#(define (note-one grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "1")))))))
  \applyOutput #'Voice #note-one c'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16[
( \set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16]
) | %{ bar 3: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8.[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16]
  \applyOutput #'Voice #note-six a4.-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a16]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 4: %}
  \applyOutput #'Voice #note-two d'4
 ~ #(define (note-dashtwo grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashtwo d'4
~   \applyOutput #'Voice #note-two d'4 #(define (note-nought grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "0")))))))
  \applyOutput #'Voice #note-nought r4
| %{ bar 5: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-five g'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
| %{ bar 6: %}
  \applyOutput #'Voice #note-three e'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
  \applyOutput #'Voice #note-one c'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16[
( \set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16]
) | %{ bar 7: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8.[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16]
  \applyOutput #'Voice #note-six a4.-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16[
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 8: %}
  \applyOutput #'Voice #note-one c'4
 ~ #(define (note-dashone grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashone c'4
~   \applyOutput #'Voice #note-one c'4   \applyOutput #'Voice #note-nought r4 | %{ bar 9: %}
  \applyOutput #'Voice #note-one c''4^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8[^.
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
) #(define (note-seven grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "7")))))))
  \applyOutput #'Voice #note-seven b'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 10: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
)   \applyOutput #'Voice #note-three e'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16[
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16]
#(define (note-four grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "4")))))))
| %{ bar 11: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8.[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
  \applyOutput #'Voice #note-seven b'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-six a'16[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8.]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 12: %}
  \applyOutput #'Voice #note-five g'4
 ~ #(define (note-dashfive grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashfive g'4
~   \applyOutput #'Voice #note-five g'4   \applyOutput #'Voice #note-nought r4 | %{ bar 13: %}
  \applyOutput #'Voice #note-one c''4^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8[^.
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
)   \applyOutput #'Voice #note-seven b'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 14: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
)   \applyOutput #'Voice #note-three e'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16[
\set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16]
| %{ bar 15: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8.[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-five g'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 16: %}
  \applyOutput #'Voice #note-one c'4
 ~   \applyOutput #'Voice #note-dashone c'4 ~   \applyOutput #'Voice #note-one c'4   \applyOutput #'Voice #note-nought r4 | %{ bar 17: %}
  \applyOutput #'Voice #note-seven b'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[]
  \applyOutput #'Voice #note-seven b'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
| %{ bar 18: %}
  \applyOutput #'Voice #note-one c''4.^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-six a'4
 ~ #(define (note-dashsix grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashsix a'4
| %{ bar 19: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8.[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
  \applyOutput #'Voice #note-seven b'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-three e'16[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8.]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 20: %}
  \applyOutput #'Voice #note-one c''4^.
 ~   \applyOutput #'Voice #note-dashone c''4 ~   \applyOutput #'Voice #note-one c''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
| %{ bar 21: %}
  \applyOutput #'Voice #note-six a'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 22: %}
  \applyOutput #'Voice #note-five g'4
 ~   \applyOutput #'Voice #note-dashfive g'4 ~   \applyOutput #'Voice #note-five g'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
| %{ bar 23: %}
  \applyOutput #'Voice #note-six a'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[]^.
  \applyOutput #'Voice #note-five g'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 24: %}
  \applyOutput #'Voice #note-one c'4
 ~   \applyOutput #'Voice #note-dashone c'4 ~   \applyOutput #'Voice #note-one c'4   \applyOutput #'Voice #note-nought r4 \bar "|." } }
% === END JIANPU STAFF ===

\new Lyrics = "IX" { \lyricsto "jianpu" { \override LyricText #'self-alignment-X = #LEFT 紅  紅  的  花  開  滿  了  木  棉  道  長  長  的  街  好  像  在  燃  燒  沈  沈  的  夜  徘  徊  在  木  棉  道  輕  輕  的  風  吹  過  了  樹  梢  木  棉  道  我  怎  能  忘  了  那  是  去  年  夏  天  的  高  潮  木  棉  道  我  怎  能  忘  了  那  是  夢  裏  難  忘  的  波  濤  啊  愛  情  就  像  木  棉  道  季  節  過  去  就  謝  了  愛  情  就  像  那  木  棉  道  蟬  聲  綿  綿  斷  不  了 } } 
>>
\layout{} }
\score {
\unfoldRepeats
<< 

% === BEGIN MIDI STAFF ===
    \new Staff { \new Voice="midi" { g'4 g'8 a'8 g'4 e'8 d'8 | %{ bar 2: %} e'4 e'8 d'8 c'4. d'16 ( e'16 ) | %{ bar 3: %} d'8. c'16 a4. a16 a16 c'8 e'8 | %{ bar 4: %} d'2. r4 | %{ bar 5: %} g'4 g'8 a'8 g'4 e'8 d'8 | %{ bar 6: %} e'4 e'8 d'8 c'4. d'16 ( e'16 ) | %{ bar 7: %} d'8. c'16 a4. e'16 d'16 e'8 d'8 | %{ bar 8: %} c'2. r4 | %{ bar 9: %} c''4 d''8 ( c''8 ) b'4 a'8 g'8 | %{ bar 10: %} a'4 a'8 ( g'8 ) e'4. e'16 e'16 | %{ bar 11: %} f'8. f'8. c''8 b'4 a'16 b'8. | %{ bar 12: %} g'2. r4 | %{ bar 13: %} c''4 d''8 ( c''8 ) b'4 a'8 g'8 | %{ bar 14: %} a'4 a'8 ( g'8 ) e'4. c'16 c'16 | %{ bar 15: %} d'8. d'8. a'8 g'4 e'8 d'8 | %{ bar 16: %} c'2. r4 | %{ bar 17: %} b'4. b'8 b'4 e'8 b'8 | %{ bar 18: %} c''4. b'8 a'2 | %{ bar 19: %} b'8. b'8. b'8 b'4 e'16 b'8. | %{ bar 20: %} c''2. r8 a'8 | %{ bar 21: %} a'4. a'8 a'8 a'8 g'8 f'8 | %{ bar 22: %} g'2. r8 a'8 | %{ bar 23: %} a'4. c''8 g'4 e'8 d'8 | %{ bar 24: %} c'2. r4 } }
% === END MIDI STAFF ===

>>
\midi { \context { \Score tempoWholesPerMinute = #(ly:make-moment 84 4)}} }
