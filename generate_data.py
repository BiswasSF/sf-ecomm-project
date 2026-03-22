import csv
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker('en_IN')  # Indian locale
random.seed(42)

START_DATE = datetime(2024, 1, 1)
END_DATE   = datetime(2024, 12, 31)

def random_date():
    delta = END_DATE - START_DATE
    return START_DATE + timedelta(days=random.randint(0, delta.days),
                                  hours=random.randint(0, 23),
                                  minutes=random.randint(0, 59))

# --- users ---
print("Generating users...")
users = []
for i in range(1, 1001):
    users.append({
        'user_id'   : i,
        'name'      : fake.name(),
        'email'     : fake.email(),
        'phone'     : fake.phone_number(),
        'city'      : fake.city(),
        'created_at': random_date().strftime('%Y-%m-%d %H:%M:%S')
    })
with open('users.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=users[0].keys())
    writer.writeheader()
    writer.writerows(users)

# --- products ---
print("Generating products...")
categories = ['Electronics', 'Clothing', 'Food', 'Books', 'Home', 'Sports']
products = []
for i in range(1, 101):
    products.append({
        'product_id': i,
        'name'      : fake.bs().title()[:100],
        'category'  : random.choice(categories),
        'price'     : round(random.uniform(50, 5000), 2),
        'created_at': random_date().strftime('%Y-%m-%d %H:%M:%S')
    })
with open('products.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=products[0].keys())
    writer.writeheader()
    writer.writerows(products)

# --- orders ---
print("Generating orders...")
statuses = ['completed', 'pending', 'cancelled', 'returned']
orders = []
for i in range(1, 5001):
    orders.append({
        'order_id'    : i,
        'user_id'     : random.randint(1, 1000),
        'status'      : random.choice(statuses),
        'total_amount': round(random.uniform(100, 10000), 2),
        'created_at'  : random_date().strftime('%Y-%m-%d %H:%M:%S')
    })
with open('orders.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=orders[0].keys())
    writer.writeheader()
    writer.writerows(orders)

# --- order_items ---
print("Generating order_items...")
items = []
item_id = 1
for order in orders:
    for _ in range(random.randint(1, 4)):
        items.append({
            'item_id'   : item_id,
            'order_id'  : order['order_id'],
            'product_id': random.randint(1, 100),
            'quantity'  : random.randint(1, 5),
            'unit_price': round(random.uniform(50, 5000), 2)
        })
        item_id += 1
with open('order_items.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=items[0].keys())
    writer.writeheader()
    writer.writerows(items)

# --- events ---
print("Generating events...")
event_types = ['page_view', 'add_to_cart', 'remove_from_cart', 'purchase', 'search']
pages       = ['home', 'product', 'cart', 'checkout', 'search', 'profile']
events = []
for i in range(1, 10001):
    events.append({
        'event_id'  : i,
        'user_id'   : random.randint(1, 1000),
        'event_type': random.choice(event_types),
        'page'      : random.choice(pages),
        'product_id': random.randint(1, 100),
        'session_id': fake.uuid4(),
        'event_at'  : random_date().strftime('%Y-%m-%d %H:%M:%S')
    })
with open('events.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=events[0].keys())
    writer.writeheader()
    writer.writerows(events)

print("Done! Files created:")
print("  users.csv       - 1,000 rows")
print("  products.csv    - 100 rows")
print("  orders.csv      - 5,000 rows")
print("  order_items.csv - ~12,000 rows")
print("  events.csv      - 10,000 rows")
