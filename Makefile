.PHONY: all
all: DraftWizard.java
	javac DraftWizard.java

.PHONY: run
run: all
	java DraftWizard

.PHONY: clean
clean:
	rm -rf *.class