package org.example.behavioral.command;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.behavioral.entity.Order;
import org.example.behavioral.handler.OrderValidationHandler;
import org.example.behavioral.notification.NotificationService;
import org.example.behavioral.payment.PaymentStrategy;
import org.example.behavioral.repository.OrderRepository;

@Slf4j
@RequiredArgsConstructor
public class PlaceOrderCommand implements OrderCommand {
    private final Order order;
    private final OrderValidationHandler validationHandler;
    private final PaymentStrategy paymentStrategy;
    private final NotificationService notificationService;
    private final OrderRepository orderRepository;

    @Override
    public void execute() {
        log.info("PlaceOrderCommand: Placing order for customer: {}", order.getCustomerName());

        if (!validationHandler.validate(order)) {
            order.updateStatus("FAILED");
            orderRepository.save(order);
            notificationService.notifyObservers("Order " + order.getId() + " failed validation");
            return;
        }

        paymentStrategy.pay(order.getTotalAmount());
        order.updateStatus("CONFIRMED");
        orderRepository.save(order);

        log.info("PlaceOrderCommand: Order placed successfully - ID: {}", order.getId());
        notificationService.notifyObservers("Order " + order.getId() + " confirmed");
    }
}
