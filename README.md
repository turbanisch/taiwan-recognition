# Taiwan Recognition

This repo makes information on countries' diplomatic relations with Taiwan from Wikipedia machine-readable. The information was extracted from the article [Foreign relations of Taiwan](https://en.wikipedia.org/wiki/Foreign_relations_of_Taiwan). Remember to modify the permalink in the script when updating.

The output contains all countries that have ever recognized Taiwan (Republic of China) diplomatically and the periods during which they have done so. Missing end dates indicate that a country still recognizes Taiwan. Actual end dates imply that a country has cut ties with Taiwan in favor of the People's Republic of China. Note that diplomatic recognition of Taiwan persisted for only a few days in some cases (e.g., Papua New Guinea and Vanuatu). Cases where countries have cut and re-established ties with Taiwan are presented as multiple rows in the output, one for each period of recognition.

When working with the data, you will most likely want to make the following modifications:

- replace missing end dates with the date of the last update
- add country identifiers that allow for historical entities such as Yugoslavia