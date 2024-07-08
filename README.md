<h1>Housing in Nashville</h1>

<h2>Description</h2>
This project involves cleaning and preparing a Nashville housing dataset for analysis. Tasks include standardizing dates, populating missing values, splitting addresses, and removing duplicates to ensure data accuracy and usability.

<h2>Features</h2>

<h3>Familiarizing with the Dataset</h3>
<ul>
  <li><b>Initial Exploration:</b> Viewed the complete dataset.</li>
</ul>

<h3>Standardize Date Format</h3>
<ul>
  <li><b>Convert Sale Date:</b> Converted "SaleDate" to a standardized format.</li>
  <li><b>Add and Update Column:</b> Added "SaleDateConverted" column and populated it with standardized dates.</li>
</ul>

<h3>Populate Missing Values</h3>
<ul>
  <li><b>Self-Join for Address:</b> Used self-join to populate missing "PropertyAddress" values based on "ParcelID".</li>
  <li><b>Update Addresses:</b> Updated "PropertyAddress" where values were initially null.</li>
</ul>

<h3>Split Address Components</h3>
<ul>
  <li><b>Extract Address and City:</b> Split "PropertyAddress" into "PropertySplitAddress" and "PropertySplitCity".</li>
  <li><b>Add and Populate Columns:</b> Added new columns and populated them with extracted values.</li>
</ul>

<h3>Split Owner Address into Components</h3>
<ul>
  <li><b>Extract Components:</b> Split "OwnerAddress" into "OwnerSplitAddress", "OwnerSplitCity", and "OwnerSplitState".</li>
  <li><b>Add and Populate Columns:</b> Added new columns and populated them with respective split values.</li>
</ul>

<h3>Standardize 'SoldAsVacant' Column</h3>
<ul>
  <li><b>View Unique Values:</b> Identified unique values in "SoldAsVacant".</li>
  <li><b>Update Values:</b> Standardized 'Y' and 'N' to 'Yes' and 'No'.</li>
</ul>

<h3>Remove Duplicate Rows</h3>
<ul>
  <li><b>Identify and Delete Duplicates:</b> Used CTE and <code>ROW_NUMBER()</code> to find and remove duplicate rows.</li>
</ul>

<h3>Delete Unused Columns</h3>
<ul>
  <li><b>Drop Columns:</b> Removed "PropertyAddress", "OwnerAddress", "TaxDistrict", and "SaleDate" columns to streamline the dataset.</li>
</ul>

<h2>Code Overview</h2>

<h3>Main Queries</h3>
<ul>
  <li><b>Standardize SaleDate:</b> Convert and store standardized sale dates.</li>
  <li><b>Populate Missing PropertyAddress:</b> Use self-join to fill in missing property addresses.</li>
  <li><b>Split PropertyAddress:</b> Extract and store address and city components.</li>
  <li><b>Split OwnerAddress:</b> Extract and store address, city, and state components of the owner address.</li>
  <li><b>Standardize SoldAsVacant:</b> Update "SoldAsVacant" values to 'Yes' and 'No'.</li>
  <li><b>Remove Duplicates:</b> Identify and delete duplicate rows.</li>
  <li><b>Delete Unused Columns:</b> Drop unnecessary columns.</li>
</ul>

