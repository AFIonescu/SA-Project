package org.example.behavioral.handler;

import lombok.extern.slf4j.Slf4j;
import org.example.behavioral.entity.Order;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class InventoryCheckHandler extends OrderValidationHandler {

    @Override
    protected boolean doValidate(Order order) {
        log.info("InventoryCheckHandler: Checking inventory for order ID: {}", order.getId());

        if (order.getTotalAmount() <= 0) {
            log.error("InventoryCheckHandler: Invalid order amount");
            return false;
        }

        log.info("InventoryCheckHandler: Inventory check passed");
        return true;
    }
}
