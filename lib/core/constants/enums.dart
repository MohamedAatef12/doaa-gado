enum BrokerTransactionMethod {
  applePay,
  paypal,
  stripe,
  bankTransfer,
  cash;

  String get value {
    switch (this) {
      case BrokerTransactionMethod.applePay:
        return 'APPLE_PAY';
      case BrokerTransactionMethod.paypal:
        return 'PAYPAL';
      case BrokerTransactionMethod.stripe:
        return 'STRIPE';
      case BrokerTransactionMethod.bankTransfer:
        return 'BANK_TRANSFER';
      case BrokerTransactionMethod.cash:
        return 'CASH';
    }
  }

  static BrokerTransactionMethod fromString(String value) {
    switch (value) {
      case 'APPLE_PAY':
        return BrokerTransactionMethod.applePay;
      case 'PAYPAL':
        return BrokerTransactionMethod.paypal;
      case 'STRIPE':
        return BrokerTransactionMethod.stripe;
      case 'BANK_TRANSFER':
        return BrokerTransactionMethod.bankTransfer;
      case 'CASH':
        return BrokerTransactionMethod.cash;
      default:
        throw Exception('Unknown BrokerTransactionMethod: $value');
    }
  }
}

enum InviteType { link, email }

enum UserInviteRole {
  client('Client'),
  driver('Driver'),
  broker('Broker');

  final String label;
  const UserInviteRole(this.label);
}
