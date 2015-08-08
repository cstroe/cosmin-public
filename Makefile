all: clean adder

adder: adder.jj
	javacc adder.jj
	javac *.java

calculator0: calculator0.jj
	javacc calculator0.jj
	javac *.java

clean:
	rm -f *.java *.class

add:
	java Adder < adder_input.txt
