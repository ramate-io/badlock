.PRECIOUS: %.ll
MAKEFLAGS += --no-builtin-rules

SRC:=$(wildcard *.rs)
OUT_TARGETS := $(patsubst %.rs,%.out,$(SRC))
ANALYSIS_TARGETS := $(patsubst %.rs,%.analysis,$(SRC))
TARGETS := $(OUT_TARGETS) $(ANALYSIS_TARGETS)

all: ${TARGETS}

%.ll: %.rs
	rustc --emit=llvm-ir $< -o $@

%.out: %.ll
	cargo b -p llvm-lock-detection
	opt-16 --load-pass-plugin=../target/debug/libllvm_lock_detection.so --passes=reentrant-lock-detection $<  | tr -cd '\11\12\15\40-\176' > $@

%.analysis : %.out
	awk '/END ANALYSIS/{exit} 1' $< > $@

clean:
	rm -rf *.ll ${TARGETS}
