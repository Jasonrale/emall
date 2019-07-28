package com.emall.rabbitmq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.MessageFormat;

@Service
public class MessageConsumer {
    @Resource
    Jackson2JsonMessageConverter converter;

    private static Logger logger = LoggerFactory.getLogger(MessageConsumer.class);

    //扇形交换机模式
    @RabbitListener(queues = RabbitConfig.FANOUT_QUEUE1)
    public void processFanout1(Message message) {
        logger.info(MessageFormat.format("receive  message : fanoutQueue1 {0}", converter.fromMessage(message)));
    }

    @RabbitListener(queues = RabbitConfig.FANOUT_QUEUE2)
    public void processFanout2(Message message) {
        logger.info(MessageFormat.format("receive  message : fanoutQueue2 {0}", converter.fromMessage(message)));
    }

    //直连交换机模式
    @RabbitListener(queues = RabbitConfig.DIRECT_QUEUE1)
    public void processDirect1(Message message) {
        logger.info(MessageFormat.format("receive  message : directQueue1 {0}", converter.fromMessage(message)));
    }

    @RabbitListener(queues = RabbitConfig.DIRECT_QUEUE2)
    public void processDirect2(Message message) {
        logger.info(MessageFormat.format("receive  message : directQueue2 {0}", converter.fromMessage(message)));
    }

    //主题交换机模式
    @RabbitListener(queues = RabbitConfig.TOPIC_QUEUE1)
    public void processTopic1(Message message) {
        logger.info(MessageFormat.format("receive  message : topicQueue1 {0}", converter.fromMessage(message)));
    }

    @RabbitListener(queues = RabbitConfig.TOPIC_QUEUE2)
    public void processTopic2(Message message) {
        logger.info(MessageFormat.format("receive  message : topicQueue2 {0}", converter.fromMessage(message)));
    }

    //首部交换机模式
    @RabbitListener(queues = RabbitConfig.HEADERS_QUEUE1)
    public void processHeaders1(Message message) {
        logger.info(MessageFormat.format("receive  message : headersQueue1 {0}", converter.fromMessage(message)));
    }

    @RabbitListener(queues = RabbitConfig.HEADERS_QUEUE2)
    public void processHeaders2(Message message) {
        logger.info(MessageFormat.format("receive  message : headersQueue2 {0}", converter.fromMessage(message)));
    }
}
