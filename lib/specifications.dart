import 'package:flutter/material.dart';


class SpecificationPage extends StatelessWidget {
  const SpecificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specification of Blanket Layer',textAlign: TextAlign.center,),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildSmallScreenContent();
          } else {
            return _buildLargeScreenContent();
          }
        },
      ),
    );
  }

  Widget _buildSmallScreenContent() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SpecificationItem(
            index: "(i)",
            content: "Cu > 7 and Cc between 1 and 3",
          ),
          SpecificationItem(
            index: "(ii)",
            content: "Fines (passing 75 microns) 3% to 10%",
          ),
          SpecificationItem(
            index: "(iii)",
            content: "Minimum soaked CBR value >= 25 (Soil compacted at 100% of MDD in Lab)",
          ),
          SpecificationItem(
            index: "(iv)",
            content: "Los Angeles Abrasion value < 40%",
          ),
          SpecificationItem(
            index: "(v)",
            content: "Field Compaction: Min. 100% of MDD in field trial",
          ),
          SpecificationItem(
            index: "(vi)",
            content: "Minimum Ev2 **= 100 MPa",
          ),
          SpecificationItem(
            index: "(vii)",
            content: "Size gradation - within specified range (as table 3.7) or should lie more or less within enveloping curves (as Fig 3.8) of comprehensive guideline",
          ),
          SpecificationItem(
            index: "(viii)",
            content: "Filter criteria (***Optional) should be satisfied with sub-grade layer as given below:",
          ),
          CriteriaItem(
            criteria: "Criteria-1",
            content: "Du (blanket) < 5 x D8S (sub-grade)",
          ),
          CriteriaItem(
            criteria: "Criteria-2",
            content: "D1S (blanket) > 4 to 5 x D|s (sub-grade)",
          ),
          CriteriaItem(
            criteria: "Criteria-3",
            content: "D50 (blanket) < 25 x D50 (sub-grade)",
          ),
        ],
      ),
    );
  }

  Widget _buildLargeScreenContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        border: TableBorder.all(color: Colors.black),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
        },
        children: const [
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Specification',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('(i)'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Cu > 7 and Cc between 1 and 3'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('(ii)'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Fines (passing 75 microns) 3% to 10%'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('(iii)'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Minimum soaked CBR value >= 25 (Soil compacted at 100% of MDD in Lab)'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('(iv)'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Los Angeles Abrasion value < 40%'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('(v)'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Field Compaction: Min. 100% of MDD in field trial'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('(vi)'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Minimum Ev2 **= 100 MPa'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('(vii)'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Size gradation - within specified range (as table 3.7) or should lie more or less within enveloping curves (as Fig 3.8) of comprehensive guideline'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('(viii)'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Filter criteria (***Optional) should be satisfied with sub-grade layer as given below:'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Criteria-1'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Du (blanket) < 5 x D8S (sub-grade)'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Criteria-2'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('D1S (blanket) > 4 to 5 x D|s (sub-grade)'),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Criteria-3'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('D50 (blanket) < 25 x D50 (sub-grade)'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SpecificationItem extends StatelessWidget {
  final String index;
  final String content;

  const SpecificationItem({super.key, required this.index, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index ',
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          ),
          Expanded(
            child: Text(content,style: const TextStyle(fontSize: 18),),
          ),
        ],
      ),
    );
  }
}

class CriteriaItem extends StatelessWidget {
  final String criteria;
  final String content;

  const CriteriaItem({super.key, required this.criteria, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$criteria: ',
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          ),
          Expanded(
            child: Text(content,style: const TextStyle(fontSize: 18),),
          ),
        ],
      ),
    );
  }
}
