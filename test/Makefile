.PRECIOUS: %.ll
MAKEFLAGS += --no-builtin-rules

SRC:=$(wildcard *.rs)
TARGETS:=$(patsubst %.rs, %, $(SRC))

all: ${TARGETS}
	@head -n100 */output/alarm.csv

%.ll: %.rs
	rustc --emit=llvm-ir $< -o $@

%: %.ll
	@mkdir -p $@/input $@/output
	../build/constraint $< $@/input 2> $@/err > $@/out
	souffle -F $@/input -D $@/output ../src/analysis.dl

clean:
	rm -rf *.ll ${TARGETS}
