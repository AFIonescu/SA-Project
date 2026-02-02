package org.example.behavioral.payment;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CreditCardPayment implements PaymentStrategy {

    @Override
    public void pay(double amount) {
        log.info("CreditCardPayment: Paid ${} with Credit Card", amount);
    }
}
