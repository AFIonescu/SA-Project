package org.example.behavioral.handler;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.example.behavioral.entity.Order;

@Slf4j
@Setter
public abstract class OrderValidationHandler {
    protected OrderValidationHandler next;

    public boolean validate(Order order) {
        if (!doValidate(order)) {
            return false;
        }
        if (next != null) {
            return next.validate(order);
        }
        return true;
    }

    protected abstract boolean doValidate(Order order);
}
