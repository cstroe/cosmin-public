all: clean adder

adder: adder.jj
	javacc adder.jj
	javac *.java

clean:
	rm -f *.java *.class
