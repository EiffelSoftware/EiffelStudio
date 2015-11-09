#!/usr/bin/python
"""
    Usage: `python generate_po.py'

    This script extracts the string messages for EiffelStudio from
    different sources and generates PO files for:
        - Error messages
        - Preferences
        - Predefined metrics
        - Wizards

    Note: The command 'msguniq' is called on each created file to
    ensure that all message id's are indeed unique. This is just
    a safety mesaure since the "add_message" method from the PoFile
    class already checks for duplicates.

    Note: The classes PoFile and PoMessage are made for this script,
    thus their implementation may or may not work if they are used
    in a different context. Use at your own risk!

    Note: Line numbers are not given for references. The xml files 
    (preferences/predefined metrics) are parsed using the python 
    dom parser which does not store line number information. The
    error messages are for the full file anyway and the wizard files
    are so small that it does not matter. 
    (It's a bad excuse, I know...)
"""


__version__ = "$Revision$"
# $Source$

import os
import re
import xml.dom.minidom
import i18n


# set up paths
# ------------

path_studio = os.path.join(os.environ.get('EIFFEL_SRC'), 'Delivery', 'studio')
path_help_error = os.path.join(path_studio, 'help', 'errors')
path_help_error_short = os.path.join(path_studio, 'help', 'errors', 'short')
path_predefined_metrics = os.path.join(path_studio, 'metrics', 'predefined_metrics.xml')
path_eifinit = os.path.join(path_studio, 'eifinit')
path_wizards = os.path.join(path_studio, 'wizards', 'new_projects')
path_documentation = os.path.join(os.environ.get('EIFFEL_SRC'), 'Documentation')

#path_output = os.path.join(path_studio, 'lang')
path_output = os.path.join('..', 'po_files')

if not os.path.isdir(path_output):
    os.makedirs(path_output)


# extract error messages
# ----------------------

po = i18n.PoFile(os.path.join (path_output, 'errors.pot'))

# extract long error messages

for filename in os.listdir (path_help_error):
    filepath = os.path.join (path_help_error, filename)
    if os.path.isfile(filepath):
        file = open(filepath, 'r')
	# Add whole file as entry to PO file
        po.add_message(
            i18n.empty_message(
                file.read(),
                'help/error/long',
                'Long description for error ' + filename,
                '$EIFFEL_SRC/Delivery/studio/help/errors/' + filename))
        file.close()

# extract short error messages

for filename in os.listdir (path_help_error_short):
    filepath = os.path.join (path_help_error_short, filename)
    if os.path.isfile(filepath):
        file = open(filepath, 'r')
	# Add whole file as entry to PO file
        po.add_message(
            i18n.empty_message(
                file.read(),
                'help/error/short',
                'Short help message for error ' + filename,
                '$EIFFEL_SRC/Delivery/studio/help/errors/short/' + filename))
        file.close()
        
po.save()
print ('generated errors.pot')
os.system('msguniq -o ' + po.filepath + ' ' + po.filepath)
print ('called msguniq to remove duplicates')


# extract default metric definitions
# ----------------------------------

po = i18n.PoFile(os.path.join(path_output, 'metrics.pot'))

dom = xml.dom.minidom.parse(path_predefined_metrics)

for metric in dom.getElementsByTagName('basic_metric'):
    # The metric tag has a "name" attribute and a child tag "description"
    name = metric.attributes['name'].value
    descriptions = metric.getElementsByTagName('description')
    if len(descriptions) > 0 and len(descriptions[0].childNodes) > 0:
        descr = descriptions[0].childNodes[0].data
    else:
        descr = ''

    # PO entry for name
    po.add_message(
        i18n.empty_message(
            name,
            'metrics/predefined/name',
            ['Name of predefined metric "' + name + '"', 'Description: ' + descr],
            '$EIFFEL_SRC/Delivery/studio/metrics/predefined_metrics.xml'))

    # PO entry for description
    po.add_message(
        i18n.empty_message(
            descr,
            'metrics/predefined/description',
            ['Description of predefined metric "' + name + '"'],
            '$EIFFEL_SRC/Delivery/studio/metrics/predefined_metrics.xml'))

po.save()
print ('generated metrics.pot')
os.system('msguniq -o ' + po.filepath + ' ' + po.filepath)
print ('called msguniq to remove duplicates')


# extract preferences
# -------------------

po = i18n.PoFile(os.path.join(path_output, 'preferences.pot'))

def extract_preference_name_parts(full_name):
    """
        Generates a list of names out of 'full_name' which is a string
        in the format "parent1_words.parent2_words.preference_words".
        It produces the same output as {PREFERENCES_GRID}.formatted_name.
    """
    parts = full_name.split('.')
    result = []
    for part in parts:
        result.append(part.capitalize().replace('_', ' '))
    return result

def extract_preferences(filepath):
    # Replace the environment variable back into the file path to make it system independent
    reference_name = filepath.replace(os.environ.get('EIFFEL_SRC'), '$EIFFEL_SRC')

    dom = xml.dom.minidom.parse(filepath)

    for preference in dom.getElementsByTagName('PREF'):
        # Every preference tag has a "NAME" and "DESCRIPTION" attribute
        name_parts = extract_preference_name_parts(preference.attributes['NAME'].value)
        # Create a pretty printed path from the names to be used as comments in the po file
        full_name = ' > '.join(name_parts)
        
        # PO entries for parent name elements
        for name in name_parts[:-1]:
            # Generate an entry for each name along the path
            po.add_message(
                i18n.empty_message(
                    name,
                    'preference/section',
                    ['Section name of preference "' + full_name + '"'],
                    reference_name))

        # Get name of last path element which is the preference name itself
        name = name_parts[-1]
        descr = preference.attributes['DESCRIPTION'].value

        # PO entry for name
        po.add_message(
            i18n.empty_message(
                name,
                'preference/name',
                ['Name of preference "' + name + '"', 'Path: ' + full_name, 'Description: ' + descr],
                reference_name))
    
        # PO entry for description
        po.add_message(
            i18n.empty_message(
                descr,
                'preference/description',
                ['Description of preference "' + name + "'", 'Path: ' + full_name],
                reference_name))

# Loop over all xml files in the eifinit directory recursively
for root, dirs, files in os.walk(path_eifinit):
     # don't visit subversion directory
    if '.svn' in dirs:
        dirs.remove('.svn')
    for file in files:
        if file.endswith('.xml'):
            filepath = os.path.join(root, file)
            extract_preferences(filepath)

po.save()
print ('generated preferences.pot')
os.system('msguniq -o ' + po.filepath + ' ' + po.filepath)
print ('called msguniq to remove duplicates')


# extract wizard descriptions
# ---------------------------

po = i18n.PoFile(os.path.join(path_output, 'wizards.pot'))

# Regular expression matches anything written within doublequotes
regexp = re.compile('"([^"]*)"')

# Look for wizard description files in the wizard directory
for filename in os.listdir (path_wizards):
    filepath = os.path.join(path_wizards, filename)
    if os.path.isfile(filepath) and filename.endswith('.dsc'):
        name = ""
        descr = ""
        # Look for the "name" and "description" line and extract text
        file = open(filepath)
        for line in file:
            if line.startswith('NAME'):
                name = regexp.findall(line)[0]
            if line.startswith('DESCRIPTION'):
                descr = regexp.findall(line)[0]
        file.close();

        # PO entry for name
        po.add_message(
            i18n.empty_message(
                name,
                'wizard/name',
                ['Name of wizard "' + name + '"', 'Description: ' + descr],
                filepath))
    
        # PO entry for description
        po.add_message(
            i18n.empty_message(
                descr,
                'wizard/description',
                ['Description of wizard "' + name + '"'],
                filepath))

po.save()
print ('generated wizards.pot')
os.system('msguniq -o ' + po.filepath + ' ' + po.filepath)
print ('called msguniq to remove duplicates')


# Extract documentation
# ---------------------

# TODO: extract xml documentation into po files
#       This is too much work for the moment (to extract,
#       to translate and to display) as it is best left for
#       later. Probably it will not be done at all...


print ('finished')

