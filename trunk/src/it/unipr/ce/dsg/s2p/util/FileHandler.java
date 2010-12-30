package it.unipr.ce.dsg.s2p.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;

/**
 * Class <code>FileHandler</code> is a file manager.
 * 
 * @author Fabrizio Caramia
 *
 */

public class FileHandler {


	/**
	 * Check if exists a file
	 * 
	 * @param fileName
	 * @return
	 */
	public boolean isFileExists(String fileName) {
		File file = new File(fileName);
		return file.exists();
	}

    /**
     * Open a file to be read
     * 
     * 
     * @param fileName
     * @return
     */
	public FileInputStream openFileToRead(String fileName){


		// File loadFile = new File(fileName);
		FileInputStream fis = null;
		try {
			
			fis = new FileInputStream(new File(fileName));

		} catch (FileNotFoundException e) {
			return null;
		}

		return fis;
	}

    /**
     * Open a file to be write
     * 
     * @param fileName
     * @return
     */
	public FileOutputStream openFileToWrite(String fileName){

		FileOutputStream fos = null;

		try {
			
			fos = new FileOutputStream(new File(fileName));
			
		} catch (FileNotFoundException e) {
			return null;
		}

		return fos;

	}
	
	/**
	 * Create a directory
	 * 
	 * @param pathName
	 * @return
	 */
	public boolean createDirectory(String pathName){
		
		
		File newDirectory = new File(pathName);
		
		return newDirectory.mkdir();
		
	}
	
	/**
	 * Check if exists a directory
	 * 
	 * @param pathName
	 * @return
	 */
	public boolean isDirectoryExists(String pathName){
		
		
		File directory = new File(pathName);
		
		return directory.isDirectory();
		
	}






}
