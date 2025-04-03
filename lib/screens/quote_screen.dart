import 'package:daily/widgets/app_background.dart';
import 'package:flutter/material.dart';
import '../services/quote_api_service.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  Quote? _quote;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadQuote();
  }

  Future<void> _loadQuote() async {
    setState(() {
      _isLoading = true;
    });

    final quote = await QuoteApiService.fetchQuote();

    setState(() {
      _quote = quote;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Motivation'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : _quote == null
                  ? Text(
                      'Error loading quote',
                      style: TextStyle(color: Colors.white),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white38,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Text(
                              '"${_quote!.q}"',
                              style: TextStyle(
                                fontSize: 22,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '- ${_quote!.a}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            onPressed: _loadQuote,
                            icon: Icon(Icons.refresh, color: Colors.white),
                            label: Text(
                              'New motivation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3A0CA3),
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
