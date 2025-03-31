package io.github.thomascgean.MathLinux;

import org.springframework.web.bind.annotation.*;

@RestController
public class MathController {

    private final MathLinux mathLinux = new MathLinux();

    @GetMapping("/add")
    public int add(@RequestParam int a, @RequestParam int b) {
        return mathLinux.addition(a, b);
    }

    @GetMapping("/subtract")
    public int subtract(@RequestParam int a, @RequestParam int b) {
        return mathLinux.subtraction(a, b);
    }

    @GetMapping("/multiply")
    public int multiply(@RequestParam int a, @RequestParam int b) {
        return mathLinux.multiplication(a, b);
    }

    @GetMapping("/divide")
    public double divide(@RequestParam double a, @RequestParam double b) {
        return mathLinux.division(a, b);
    }
}
