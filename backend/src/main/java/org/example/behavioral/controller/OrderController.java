package org.example.behavioral.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.behavioral.entity.Order;
import org.example.behavioral.service.OrderService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/behavioral/orders")
@RequiredArgsConstructor
@Tag(name = "Behavioral Patterns", description = "Chain of Responsibility, Command, Observer, Strategy pattern endpoints")
public class OrderController {

    private final OrderService orderService;

    @Operation(summary = "Place a new order", description = "Creates and processes an order using Command pattern, validates with Chain of Responsibility, pays with Strategy, notifies with Observer")
    @PostMapping
    public ResponseEntity<Order> placeOrder(@RequestBody Order order) {
        log.info("OrderController: Received request to place order");
        Order placedOrder = orderService.placeOrder(order);
        return ResponseEntity.ok(placedOrder);
    }

    @Operation(summary = "Get all orders", description = "Returns all orders from the database")
    @GetMapping
    public ResponseEntity<List<Order>> getAllOrders() {
        log.info("OrderController: Fetching all orders");
        return ResponseEntity.ok(orderService.getAllOrders());
    }

    @Operation(summary = "Get order by ID", description = "Returns a specific order by its ID")
    @GetMapping("/{id}")
    public ResponseEntity<Order> getOrderById(@PathVariable Long id) {
        log.info("OrderController: Fetching order with ID: {}", id);
        return orderService.getOrderById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
