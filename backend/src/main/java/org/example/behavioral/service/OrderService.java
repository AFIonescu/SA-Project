package org.example.behavioral.service;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.behavioral.entity.Order;
import org.example.behavioral.command.OrderCommand;
import org.example.behavioral.command.PlaceOrderCommand;
import org.example.behavioral.handler.InventoryCheckHandler;
import org.example.behavioral.handler.PaymentValidationHandler;
import org.example.behavioral.notification.EmailNotification;
import org.example.behavioral.notification.NotificationService;
import org.example.behavioral.notification.SMSNotification;
import org.example.behavioral.payment.CreditCardPayment;
import org.example.behavioral.repository.OrderRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final NotificationService notificationService;
    private final InventoryCheckHandler inventoryCheckHandler;
    private final PaymentValidationHandler paymentValidationHandler;
    private final CreditCardPayment creditCardPayment;
    private final EmailNotification emailNotification;
    private final SMSNotification smsNotification;

    @PostConstruct
    public void init() {
        log.info("OrderService: Initializing validation chain and observers");

        inventoryCheckHandler.setNext(paymentValidationHandler);

        notificationService.addObserver(emailNotification);
        notificationService.addObserver(smsNotification);

        log.info("OrderService: Initialization complete");

        log.info("OrderService: Creating sample orders");
        createSampleOrders();
    }

    private void createSampleOrders() {
        Order order1 = new Order(null, "Alice Johnson", "PENDING", 299.99);
        placeOrder(order1);

        Order order2 = new Order(null, "Bob Smith", "PENDING", 149.50);
        placeOrder(order2);

        Order order3 = new Order(null, "Carol Williams", "PENDING", 599.00);
        placeOrder(order3);

        log.info("OrderService: Sample orders created successfully");
    }

    public Order placeOrder(Order order) {
        log.info("OrderService: Placing order for customer: {}", order.getCustomerName());

        order.setStatus("PENDING");
        Order savedOrder = orderRepository.save(order);

        OrderCommand placeOrderCommand = new PlaceOrderCommand(
                savedOrder,
                inventoryCheckHandler,
                creditCardPayment,
                notificationService,
                orderRepository
        );

        placeOrderCommand.execute();

        return savedOrder;
    }

    public List<Order> getAllOrders() {
        log.debug("OrderService: Fetching all orders");
        return orderRepository.findAll();
    }

    public Optional<Order> getOrderById(Long id) {
        log.debug("OrderService: Fetching order with ID: {}", id);
        return orderRepository.findById(id);
    }
}
