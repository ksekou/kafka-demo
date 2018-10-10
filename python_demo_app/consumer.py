import asyncio
from aiokafka import AIOKafkaConsumer


async def do_something(msg):
    print(f'Consumed: [{msg.value}] from [{msg.topic}] :=> (P={msg.partition}, O={msg.offset})')


async def consume(loop, topics):
    consumer = AIOKafkaConsumer(
        *topics,
        loop=loop,
        group_id="test-group",
        bootstrap_servers=[
            'srv-kafka1:9092',
            'srv-kafka2:9092'
        ]
    )
    await consumer.start()
    try:
        async for msg in consumer:
            await do_something(msg)
    finally:
        await consumer.stop()


if __name__ == '__main__':
    TOPICS = ('TEST-TOPIC', )
    loop = asyncio.get_event_loop()
    loop.run_until_complete(consume(loop, TOPICS))
