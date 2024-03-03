
# overridable from the same environment variable
# https://stackoverflow.com/a/53370979/2125837
j2ly_lyric_size ?= 24
j2ly_staff_size ?= 24

# https://devhints.io/makefile
ly_files := $(wildcard *.ly)
md_files := $(wildcard *.midi)

all: ly md

ly: $(ly_files)

# separated lyrics rule
%.ly: %.gp.jp  %.lr.ly
	@echo Generating lilypond from jianpu with lyric_size=$(j2ly_lyric_size) staff_size=$(j2ly_staff_size)
	( jianpu-ly.py < $*.gp.jp; cat $*.lr.ly ) > $@ # $*.ly
# naming convention
# .gp.jp: gepu in jianpu form
# lr.ly: lyrics in lilypond form

# simple jianpu rule
%.ly: %.jp
	@echo Generating lilypond from jianpu with lyric_size=$(j2ly_lyric_size) staff_size=$(j2ly_staff_size)
	jianpu-ly.py < $< > $@

md: $(md_files)
#$(info    checking for $(md_files))

%.midi: %.ly
	@printf "\nGenerating music sheet from lilypond\n"
	lilypond --png $<

view: $(shell ls -t *.png | head -1) # ly md # No, do NOT recompile!
	qiv -t $< &

