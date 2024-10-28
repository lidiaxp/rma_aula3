#!/usr/bin/env python
import rospy
from sensor_msgs.msg import LaserScan


class ScanSubscriber:
    def __init__(self):
        rospy.init_node('scan_subscriber', anonymous=True)

        topic_name = rospy.get_param('~topic_name', 'scan')
        queue_size = rospy.get_param('~queue_size', 10)

        self.subscription = rospy.Subscriber(
            topic_name,
            LaserScan,
            self.listener_callback,
            queue_size=queue_size
        )

        rospy.loginfo(f'Subscribe to the topic: {topic_name} with the queue size: {queue_size}')


    def listener_callback(self, msg):
        rospy.loginfo(f'Received data from scan: [Ranges: {len(msg.ranges)}]')


    def run(self):
        rospy.spin() 


if __name__ == '__main__':
    try:
        scan_subscriber = ScanSubscriber()
        scan_subscriber.run()
    except rospy.ROSInterruptException:
        pass
