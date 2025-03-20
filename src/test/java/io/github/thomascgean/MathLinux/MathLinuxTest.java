package io.github.thomascgean.MathLinux;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class MathLinuxTest {

	@Test
	void addTest() {
		MathLinux test = new MathLinux();
		int sum = test.addition(5,10);
		assertEquals(15, sum);
	}
	@Test
	void diffTest() {
		MathLinux test = new MathLinux();
		int difference = test.subtraction(4, 1);
		assertEquals(3, difference);
	}
	@Test
	void multTest() {
		MathLinux test = new MathLinux();
		int product = test.multiplication(4, 3);
		assertEquals(12,product);
	}
	@Test
	void divTest() {
		MathLinux test = new MathLinux();
		double quotient = test.division(10, 2);
		assertEquals(5,quotient);
	}
	@Test
	void divZeroTest() {
		MathLinux test = new MathLinux();
		double divZero = test.division(5,0);
		assertEquals(-1,divZero);
	}
}