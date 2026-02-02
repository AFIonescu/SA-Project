package org.example.behavioral.handler;

import lombok.extern.slf4j.Slf4j;
import org.example.behavioral.entity.Order;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class PaymentValidationHandler extends OrderValidationHandler {

    @Override
    protected boolean doValidate(Order order) {
        log.info("PaymentValidationHandler: Validating payment for order ID: {}", order.getId());

        if (order.getTotalAmount() <= 0) {
            log.error("PaymentValidationHandler: Invalid payment amount");
            return false;
        }

        log.info("PaymentValidationHandler: Payment validation passed");
        return true;
    }
}
