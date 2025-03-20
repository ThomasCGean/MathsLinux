package io.github.thomascgean.MathLinux;

public class MathLinux {

	public int addition(int first, int second) {
		return first + second;
	}
	
	public int subtraction(int a, int b) {
		return a - b;
	}
	
	public int multiplication(int a, int b) {
		return a * b;
	}
	
	public double division(double a, double b) {
		if(b == 0) return -1;
		return a / b;
	}
}