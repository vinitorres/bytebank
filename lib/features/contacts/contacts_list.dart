import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/features/contact_form/contact_form.dart';
import 'package:bytebank/features/transaction_form/transaction_form.dart';
import 'package:bytebank/model/contact.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data ?? [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(
                    contact: contact,
                    onClick: () => {
                      _showTransactionForm(context, contact),
                    },
                  );
                },
                itemCount: contacts.length,
              );
          }
          return const Text('Erro desconhecido');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showTransactionForm(BuildContext context, Contact contact) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionForm(contact),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  const _ContactItem({required this.contact, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 24.0),
        ),
        subtitle: Text('${contact.accountNumber}'),
      ),
    );
  }
}
