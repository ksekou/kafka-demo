import sys
import asyncio
from aiokafka import AIOKafkaProducer


async def send(loop, topics, total_msg=100):

    producer = AIOKafkaProducer(
        loop=loop,
        bootstrap_servers=[
            'srv-kafka1:9092',
            'srv-kafka2:9092'
        ]
    )
    await producer.start()
    try:
        await asyncio.wait([
            producer.send_and_wait(topic, f'Super message: {count}'.encode())
            for topic in topics for count in range(total_msg)
        ])
    finally:
        # Wait for all pending messages to be delivered or expire.
        await producer.stop()

if __name__ == '__main__':
    try:
        TOTAL_MSG = int(sys.argv[-1])
    except:
        TOTAL_MSG = 10
    TOPICS = ('TEST-TOPIC', )
    loop = asyncio.get_event_loop()
    loop.run_until_complete(send(loop, TOPICS, TOTAL_MSG))
